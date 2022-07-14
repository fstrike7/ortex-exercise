import pandas as pd
import os
import sys


class Main():
    def __init__(self):
        self.path = os.path.abspath('.')

    def run(self):
        """
        Read a .csv file and run 3 methods which represents 3 different tasks.
        """
        class Colors:
            HEADER = '\033[95m'
            NORMAL = '\033[0m'
        path = self.path+'/../2017.csv'
        df = self.read_csv(path)
        print(df.head())
        # Task 1: Which are the top 3 source with the highest ratio of Buy to Sell transactions weighted by the number of shares per transaction
        top_source_df = self.get_top_source(df)
        print(Colors.HEADER+"Top 3 source with the highest ratio of Buy to Sell transactions weighted by the number of shares per transaction:"+Colors.NORMAL)
        print(top_source_df)
        # Task 2: Which are the top 3 currency by the total numerical value of trades in that currency
        top_currency_df = self.get_top_currencies(df)
        print(Colors.HEADER+"Top 3 currency by the total numerical value of trades in that currency:"+Colors.NORMAL)
        print(top_currency_df)
        # Task 3: What is the total number of transactions where inputdate was more than 2 weeks after tradedate
        more_than_two_weeks_df = self.more_than_two_weeks(df)
        print(Colors.HEADER+"Total number of transactions where inputdate was more than 2 weeks after tradedate:"+Colors.NORMAL)
        print(more_than_two_weeks_df.size)
        answer = input("Do you want to export the results? (Y/N):")
        assert answer.lower() in ('y', 'n'), 'Incorrect option'
        if answer == 'y':
            os.mkdir(os.path.join(self.path, 'results'))
            top_source_df.to_csv(self.path+'/results/top_source_df.csv')
            top_currency_df.to_csv(self.path+'/results/top_currency_df.csv')
            more_than_two_weeks_df.to_csv(
                self.path+'/results/more_than_two_weeks_df.csv')
            print("Exported to /results/ folder")
        else:
            return

    def read_csv(self, file_path: str) -> pd.DataFrame:
        """
        Parameters:
        - file_path: string that contains the path to the csv file. Example: "C:/Users/Public/2017.csv"
        Returns:
        - pandas.DataFrame
        """
        print("Reading .csv file...")
        df = pd.read_csv(file_path)
        if df.empty:
            raise Exception("No Dataframe obtained.")
        return df

    def get_top_source(self, df: pd.DataFrame) -> pd.DataFrame:
        new_df = df[['shares', 'source']].groupby(
            'source').sum().sort_values('shares', ascending=False).head(3)
        return new_df

    def get_top_currencies(self, df: pd.DataFrame):
        new_df = df.copy()
        print(new_df[['transactionID', 'value']].head())
        new_df = df[['currency', 'value']].groupby(
            'currency').sum().sort_values('value', ascending=False).head(3)
        return new_df

    def more_than_two_weeks(self, df):
        new_df = df.copy()
        new_df['inputdate'] = pd.to_datetime(
            new_df['inputdate'], format="%Y%m%d")
        new_df['tradedate'] = pd.to_datetime(
            new_df['tradedate'], format="%Y%m%d")
        # Saves difference between two dates, like "17 days"
        new_df['difference'] = new_df['inputdate']-new_df['tradedate']
        print(new_df[['inputdate', 'tradedate', 'difference']])
        # Return only those that "difference" is more than 14.
        return new_df[new_df['difference'].astype('timedelta64[D]') > 14]


if __name__ == '__main__':
    app = Main()
    app.run()
