import tushare as ts

pro = ts.pro_api('e826b583d264906bbf69b8d91c22a29c4c25839a7f13e02c7d869e85')
# df = pro.trade_cal(exchange='', start_date='20180901', end_date='20181001',
#                    fields='exchange,cal_date,is_open,pretrade_date', is_open='0')
# # pandas转json，主要使用records
# print(df.to_json(orient='records'))
# print(df.to_json(orient='index'))

def financeinfo_1_func(ts_code, start_time, end_time):
    df = pro.income(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')


def financeinfo_2_func(ts_code, start_time, end_time):
    df = pro.balancesheet(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')

def financeinfo_3_func(ts_code, start_time, end_time):
    df = pro.cashflow(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')


def financeinfo_4_func(ts_code, start_time, end_time):
    df = pro.fina_indicator(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')


def financeinfo_5_func(ts_code, start_time, end_time):
    df = pro.fina_audit(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')