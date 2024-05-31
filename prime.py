def is_prime(n):
    """
    Check if a number is prime.

    Args:
        n (int): The number to check.

    Returns:
        bool: True if the number is prime, False otherwise.
    """
    # Check if the number is less than 2, which is not prime
    if n < 2:
        return False

    # Iterate from 2 to the square root of n (inclusive)
    for i in range(2, int(n**0.5) + 1):
        # If n is divisible by i, it is not prime
        if n % i == 0:
            return False

    # If the loop completes without finding a divisor, n is prime
    return True

# create a function to do 5 unit tests of the code above
def test_is_prime():
    assert is_prime(2) == True
    assert is_prime(3) == True
    assert is_prime(4) == False
    assert is_prime(5) == True
    assert is_prime(6) == False
    print("All tests pass")
        
