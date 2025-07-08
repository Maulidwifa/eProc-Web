from selenium.webdriver import ChromeOptions

def create_chrome_options_with_scale(scale_factor='0.75'):
    options = ChromeOptions()
    options.add_argument(f'--force-device-scale-factor={scale_factor}')
    return options
