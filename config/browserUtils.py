from selenium.webdriver import ChromeOptions

def create_chrome_options_with_scale(scale_factor='0.75'):
    options = ChromeOptions()
    options.add_argument(f'--force-device-scale-factor={scale_factor}')

    # Cegah save-password popup
    options.add_argument('--disable-save-password-bubble')
    options.add_argument('--disable-infobars')
    options.add_argument('--disable-notifications')
    options.add_argument('--disable-extensions')
    options.add_argument('--start-maximized')
    options.add_argument('--incognito')  # Gunakan mode incognito
    # gunakan mode tamu (tidak simpan password)

    # Nonaktifkan fitur sinkronisasi & notifikasi
    options.add_argument('--disable-features=SendTabToSelf,Sync,Notifications')
    options.add_argument('--disable-gcm-registration')
    options.add_argument('--no-default-browser-check')
    options.add_argument('--log-level=3')
    options.add_argument('--disable-logging')
    options.add_argument('--no-sandbox')

    # Nonaktifkan password manager dan notifikasi
    options.add_experimental_option("prefs", {
        "credentials_enable_service": False,
        "profile.password_manager_enabled": False,
        "profile.default_content_setting_values.notifications": 2
    })

    return options
