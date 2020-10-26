from AndroidRunner.Device import Device
from datetime import datetime


# noinspection PyUnusedLocal
def main(device: Device, *args: tuple, **kwargs: dict):
    start = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    print('End run at: ', start)
