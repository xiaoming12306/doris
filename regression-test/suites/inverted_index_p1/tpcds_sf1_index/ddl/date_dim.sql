CREATE TABLE IF NOT EXISTS date_dim (
    d_date_sk bigint,
    d_date_id char(16),
    d_date date,
    d_month_seq integer,
    d_week_seq integer,
    d_quarter_seq integer,
    d_year integer,
    d_dow integer,
    d_moy integer,
    d_dom integer,
    d_qoy integer,
    d_fy_year integer,
    d_fy_quarter_seq integer,
    d_fy_week_seq integer,
    d_day_name char(9),
    d_quarter_name char(6),
    d_holiday char(1),
    d_weekend char(1),
    d_following_holiday char(1),
    d_first_dom integer,
    d_last_dom integer,
    d_same_day_ly integer,
    d_same_day_lq integer,
    d_current_day char(1),
    d_current_week char(1),
    d_current_month char(1),
    d_current_quarter char(1),
    d_current_year char(1),
    INDEX d_date_sk_idx(d_date_sk) USING INVERTED COMMENT "d_date_sk index",
    INDEX d_date_id_idx(d_date_id) USING INVERTED COMMENT "d_date_id index",
    INDEX d_date_idx(d_date) USING INVERTED COMMENT "d_date index",
    INDEX d_month_seq_idx(d_month_seq) USING INVERTED COMMENT "d_month_seq index",
    INDEX d_week_seq_idx(d_week_seq) USING INVERTED COMMENT "d_week_seq index",
    INDEX d_quarter_seq_idx(d_quarter_seq) USING INVERTED COMMENT "d_quarter_seq index",
    INDEX d_year_idx(d_year) USING INVERTED COMMENT "d_year index",
    INDEX d_dow_idx(d_dow) USING INVERTED COMMENT "d_dow index",
    INDEX d_moy_idx(d_moy) USING INVERTED COMMENT "d_moy index"
)
DUPLICATE KEY(d_date_sk, d_date_id)
DISTRIBUTED BY HASH(d_date_id) BUCKETS 3
PROPERTIES (
  "replication_num" = "1"
)
