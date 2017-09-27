# rubocop:disable Eval
# rubocop:disable MethodLength
# rubocop:disable AbcSize
# rubocop:disable ParameterLists
require 'find_by_sql_paginately/version'

module FindBySqlPaginately
  module ActiveRecordExtension
    def self.prepended(base)
      class << base
        prepend ClassMethods
      end
    end

    module ClassMethods
      def find_by_sql(
        sql,
        binds = [],
        preparable: nil,
        per_page: 4_294_967_296, # 2 ** 32
        page: 1,
        &block
      )
        sanitize_sql = sanitize_sql(sql)
        final_sql = if per_page == 4_294_967_296
                      sanitize_sql
                    else
                      %(
                        SELECT * FROM (#{sanitize_sql}) AS paginateable
                        LIMIT #{per_page}
                        OFFSET #{(page - 1) * per_page}
                      )
                    end

        records = super(
          final_sql, binds, preparable: preparable, &block
        )

        kclass = to_s
        records.instance_eval do
          eval <<-RUBY, nil, __FILE__, __LINE__ + 1
            def sql
              %(#{sanitize_sql})
            end

            def page
              "#{page}".to_i
            end

            def per_page
              "#{per_page}".to_i
            end

            def kclass
              "#{kclass}"
            end
          RUBY
        end

        records.instance_eval do
          def total_pages
            @total_pages ||= (total_count * 1.0 / per_page).ceil.to_i
          end

          def total_count
            return @total_count if @total_count

            count_sql = %(
              SELECT COUNT(*) AS count FROM (#{sql}) AS paginateable
            )

            @total_count ||=
              kclass
              .constantize
              .find_by_sql(count_sql)
              .first
              .count
          end
        end

        records
      end
    end
  end
end

ActiveSupport.on_load :active_record do
  ::ActiveRecord::Base.send :prepend, FindBySqlPaginately::ActiveRecordExtension
end
