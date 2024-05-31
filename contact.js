/**
 * Validates a phone number using a regular expression.
 *
 * @param {string} phoneNumber - The phone number to validate.
 * @returns {boolean} - Returns true if the phone number is valid, otherwise false.
 */
function validatePhoneNumber(phoneNumber) {
    // Regular expression to validate global phone numbers
    const regex = /^\+(?:[0-9] ?){6,14}[0-9]$/;

    return regex.test(phoneNumber);
}


area_codes = {
    "AL": ["205", "251", "256", "334", "938"],
    "AK": ["907"],
    "AZ": ["480", "520", "602", "623", "928"],
    "AR": ["479", "501", "870"],
    "CA": ["209", "213", "310", "323", "408", "415", "424", "442", "510", "530"],
    # ... add the rest of the states here ...
}

# Accessing area codes for a state
print(area_codes["CA"])  # Output: ['209', '213', '310', '323', '408', '415', '424', '442', '510', '530']

area_codes = {
    "AL": ["205", "251", "256", "334", "938"],
    "AK": ["907"],
    "AZ": ["480", "520", "602", "623", "928"],
    "AR": ["479", "501", "870"],
    "CA": ["209", "213", "310", "323", "408"],
    # ... add the rest of the states here ...
}

# Accessing area codes for a state
print(area_codes["CA"])  # Output: ['209', '213', '310', '323', '408']

area_codes = {
    "AL": ["205", "251", "256", "334", "938"],
    "AK": ["907"],
    "AZ": ["480", "520", "602", "623", "928"],
    "AR": ["479", "501", "870"],
    "CA": ["209", "213", "310", "323", "408", "415", "424", "442", "510", "530"],
    "CO": ["303", "719", "720", "970"],
    "CT": ["203", "475", "860", "959"],
    "DE": ["302"],
    "FL": ["239", "305", "321", "352", "386", "407", "561", "727", "754", "772"],
    # ... add the rest of the states here ...
}

# Accessing area codes for a state
print(area_codes["FL"])  # Output: ['239', '305', '321', '352', '386', '407', '561', '727', '754', '772']