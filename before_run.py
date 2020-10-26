from AndroidRunner.Device import Device
from datetime import datetime


# noinspection PyUnusedLocal
def main(device: Device, *args: tuple, **kwargs: dict):
    start = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    print('Starting run at: ', start)
    device.force_stop("com.whatsapp")
    device.force_stop("com.facebook.orca")
    device.force_stop("org.telegram.messenger")
