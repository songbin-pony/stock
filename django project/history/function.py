import tushare as ts

pro = ts.pro_api('e826b583d264906bbf69b8d91c22a29c4c25839a7f13e02c7d869e85')


def dayinfofunc(ts_code, start_time, end_time):
    df = pro.daily(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')


def weekinfofunc(ts_code, start_time, end_time):
    df = pro.weekly(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')


def monthinfofunc(ts_code, start_time, end_time):
    df = pro.monthly(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')

def moneyflowfunc(ts_code, start_time, end_time):
    df = pro.moneyflow(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.to_json(orient='records')
