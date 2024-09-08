function checkPrime(arr) {
  for (let num of arr) {
    if (num > 1) {
      for (let i = 2; i < num; i++) {
        if (num % i == 0) {
          break; // not a prime number
        }
      }
      if (i == num) {
        console.log(num + " is a prime number.");
      }
    }
  }
}