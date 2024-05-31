import unittest
from prime import is_prime

class TestPrime(unittest.TestCase):
    def test_is_prime(self):
        self.assertFalse(is_prime(1), "1 is not a prime number")
        self.assertTrue(is_prime(2), "2 is a prime number")
        self.assertFalse(is_prime(4), "4 is not a prime number")
        self.assertTrue(is_prime(5), "5 is a prime number")
        self.assertFalse(is_prime(15), "15 is not a prime number")
        self.assertTrue(is_prime(17), "17 is a prime number")

if __name__ == '__main__':
    unittest.main()