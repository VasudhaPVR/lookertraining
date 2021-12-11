 view: order_items {
   derived_table: {
     sql: SELECT
         user_id as user_id
         , COUNT(*) as lifetime_orders
         , MAX(orders.created_at) as most_recent_purchase_at
       FROM orders
       GROUP BY user_id
       ;;
   }

   dimension: user_id {
    type: number
     sql: ${TABLE}.user_id ;;
   }

   dimension: lifetime_orders {
     type: number
     sql: ${TABLE}.lifetime_orders ;;
   }

   dimension_group: most_recent_purchase {
     type: time
     timeframes: [date, week, month, year]
     sql: ${TABLE}.most_recent_purchase_at ;;
   }
   measure: total_lifetime_orders {
     type: sum
     sql: ${lifetime_orders} ;;
   }
 }
