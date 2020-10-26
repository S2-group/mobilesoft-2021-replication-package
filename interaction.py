from AndroidRunner.Device import Device
from time import sleep, time
from datetime import datetime

###################
# WHATSAPP SCRIPT
###################
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys


def whatsapp_script(num_of_msgs, sleep_btw_msgs, burst=False):
    options = webdriver.ChromeOptions()
    options.add_argument(r"user-data-dir=./whatsapp_data")

    navigator = webdriver.Chrome(options=options)
    navigator.get("https://web.whatsapp.com/")

    contact = "Green Lab Contact"
    text = "Message "

    inp_xpath_search = '//*[@id="side"]/div[1]/div/label/div/div[2]'
    input_box_search = WebDriverWait(navigator, 50).until(
        lambda driver: driver.find_element_by_xpath(inp_xpath_search))
    input_box_search.click()
    sleep(2)
    input_box_search.send_keys(contact)
    sleep(2)
    selected_contact = navigator.find_element_by_xpath("//span[@title='" + contact + "']")
    selected_contact.click()
    inp_xpath = '//*[@id="main"]/footer/div[1]/div[2]/div/div[2]'
    input_box = navigator.find_element_by_xpath(inp_xpath)
    sleep(2)
    if burst:
        for i in range(0, num_of_msgs):
            if i > 0 and i % 50 == 0:
                sleep(60)
            msg = text + str(i)
            input_box.send_keys(msg + Keys.ENTER)

    else:
        for i in range(0, num_of_msgs):
            msg = text + str(i)
            input_box.send_keys(msg + Keys.ENTER)
            sleep(sleep_btw_msgs)

    sleep(1)
    navigator.quit()


##################
# TELEGRAM SCRIPT
##################
import asyncio
from telethon.tl.functions.messages import SendMessageRequest
from telethon import TelegramClient


async def tg_script(num_of_msgs, sleep_btw_msgs, burst=False):
    # get your api_id, api_hash, token
    # from telegram as described above
    api_id = 1811538
    api_hash = '2eba8a31f596056ea994eef042a393d0'

    # your phone number
    phone = '+32488236947'

    # creating a telegram session and assigning
    # it to a variable client
    client = TelegramClient('session', api_id, api_hash)

    # connecting and building the session
    await client.connect()

    if not await client.is_user_authorized():
        print('Input code.')
        await client.send_code_request(phone)
        #     # signing in the client
        await client.sign_in(phone, 43000)

    try:
        if burst:
            for i in range(0, num_of_msgs):
                if i > 0 and i % 50 == 0:
                    sleep(60)
                await client(SendMessageRequest('SteliosGreenLab', 'Message {}'.format(i)))
        else:
            for i in range(0, num_of_msgs):
                await client(SendMessageRequest('SteliosGreenLab', 'Message {}'.format(i)))
                sleep(sleep_btw_msgs)

    except Exception as e:
        raise e

    # disconnecting the telegram session
    await client.disconnect()
    return


# noinspection PyUnusedLocal
def main(device: Device, *args: tuple, **kwargs: dict):
    run_duration = 300  #seconds
    sleep_btw_msgs = 1.2
    num_of_msgs = 250
    run_start = time()

    debug_time = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    print('Starting interaction at: ', debug_time)

    current_activity = device.current_activity()
    if current_activity == "com.whatsapp":
        whatsapp_script(num_of_msgs, sleep_btw_msgs, burst=True)
    else:
        asyncio.run(tg_script(num_of_msgs, sleep_btw_msgs, burst=True))
        pass

    run_time = time() - run_start
    if run_time < run_duration:
        diff = run_duration-run_time
        print('Message sending done. Sleeping for {} seconds (diff)'.format(diff))
        sleep(diff)