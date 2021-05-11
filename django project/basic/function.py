import tushare as ts

pro = ts.pro_api('e826b583d264906bbf69b8d91c22a29c4c25839a7f13e02c7d869e85')


def basicinfofunc(ts_code):
    df = pro.stock_company(ts_code=ts_code)
    return df.to_json(orient='records')


def manageinfofunc(ts_code):
    df = pro.stk_managers(ts_code=ts_code)
    return df.to_json(orient='records')


def manageholdinfofunc(ts_code):
    df = pro.stk_rewards(ts_code=ts_code)
    return df.to_json(orient='records')