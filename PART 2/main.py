from numpy import empty
import pandas as pd
import os
class Main():
    def __init__(self):
        self.path = os.path.abspath('.')
        pass
    def run(self):
        """
        
        """
        df = self.read_csv(self.path+'/../2017.csv')
        print(df)
        # Task 1: Which are the top 3 source with the highest ratio of Buy to Sell transactions weighted by the number of shares per transaction
        top_source_df = self.get_top_source(df)
        print("Top 3 source with the highest ratio of Buy to Sell transactions weighted by the number of shares per transaction: ")
        print(top_source_df)
        # Task 2: Which are the top 3 currency by the total numerical value of trades in that currency
        top_currency_df = self.get_top_currencies(df)

    def read_csv(self, file_path: str) -> pd.DataFrame:
        """
        Parameters:
        - file_path: string that contains the path to the csv file. Example: "C:/Users/Public/2017.csv"
        """
        print("Reading .csv file.")
        df = pd.read_csv(file_path)
        if df.empty:
            raise Exception("No Dataframe obtained.")
        return df
    
    def get_top_source(self, df: pd.DataFrame) -> pd.DataFrame:
        new_df = df[['shares','source']].groupby('source').sum().sort_values('shares',ascending=False).head(3)
        return new_df
    
    def get_top_currencies(self, df: pd.DataFrame):
        pass
    # Me queda pendiente.
        #new_df = df[['transactionId', '']]
if __name__ == '__main__':
    app = Main()
    app.run()
