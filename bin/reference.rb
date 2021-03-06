require 'csv'
require 'jpstock'

CSV.open('ref_index.csv', "wb") do |csv|
  csv << ["銘柄コード", "銘柄名称", "始値", "高値", "安値", "終値", "前日終値", "出来高", "時価総額 (百万円)", "発行済株式数", "配当利回り (会社予想)", "1 株配当 (会社予想)", "PER (会社予想)", "PBR (実績)", "EPS (会社予想)", "BPS (実績)", "最低購入代金", "単元株数", "年初来高値", "年初来安値"]

  CSV.foreach('stocks.txt') do |row|
    code = row[0]
    if code
      unless code == "N225"
        jps = JpStock.quote(:code=>code)
        csv << [jps.code, jps.company_name, jps.open, jps.high, jps.low, jps.close, jps.prev_close, jps.volume, jps.market_cap, jps.shares_issued, jps.dividend_yield, jps.dividend_one, jps.per, jps.pbr, jps.eps, jps.bps, jps.price_min, jps.round_lot, jps.years_high, jps.years_low] unless jps.nil?
      end
    end
  end
end
