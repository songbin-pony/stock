import tushare as ts

pro = ts.pro_api('e826b583d264906bbf69b8d91c22a29c4c25839a7f13e02c7d869e85')


def forecastdata(ts_code, start_time, end_time):
    df = pro.daily(ts_code=ts_code, start_date=start_time, end_date=end_time)
    return df.iloc[:, 1].values, df.iloc[:, 5].values


def getstockprice(ts_code_list, start_time, end_time):
    datadict = {}
    for item in ts_code_list:
        df = pro.daily(ts_code=item, start_date=start_time, end_date=end_time)
        df = df.loc[:, ['trade_date', 'close']]
        # 在这里需要将array转化为list，十分重要，务必牢记
        df = df.values.tolist()
        datadict[item] = df
    return datadict
