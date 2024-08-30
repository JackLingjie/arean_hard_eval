**Edge Test Cases for FICO Score and Number of Inquiries**

### Overview

The following test cases cover the edge scenarios for the condition:

- `FICO > 750 && FICO <= 900`
- `N_INQ < 2`

### Test Cases

#### **Test Case 1: High FICO Score**

- **Description**: Verify that a high FICO score within the specified range (`FICO > 750 && FICO <= 900`) is accepted.
- **Preconditions**: 
  - FICO score is 751.
  - Number of inquiries (`N_INQ`) is 1.
- **Expected Result**: The condition is met.

#### **Test Case 2: Low FICO Score**

- **Description**: Verify that a low FICO score outside the specified range (`FICO > 750 && FICO <= 900`) is rejected.
- **Preconditions**: 
  - FICO score is 700.
  - Number of inquiries (`N_INQ`) is 1.
- **Expected Result**: The condition is not met.

#### **Test Case 3: High Number of Inquiries**

- **Description**: Verify that a high number of inquiries (`N_INQ >= 2`) is rejected.
- **Preconditions**: 
  - FICO score is 800.
  - Number of inquiries (`N_INQ`) is 3.
- **Expected Result**: The condition is not met.

#### **Test Case 4: Low Number of Inquiries**

- **Description**: Verify that a low number of inquiries (`N_INQ < 2`) is accepted.
- **Preconditions**: 
  - FICO score is 800.
  - Number of inquiries (`N_INQ`) is 0.
- **Expected Result**: The condition is met.

#### **Test Case 5: Edge Case - FICO Score at Upper Limit**

- **Description**: Verify that a FICO score at the upper limit (`FICO = 900`) is accepted.
- **Preconditions**: 
  - FICO score is 900.
  - Number of inquiries (`N_INQ`) is 1.
- **Expected Result**: The condition is met.

#### **Test Case 6: Edge Case - FICO Score at Lower Limit**

- **Description**: Verify that a FICO score at the lower limit (`FICO = 750`) is accepted.
- **Preconditions**: 
  - FICO score is 750.
  - Number of inquiries (`N_INQ`) is 1.
- **Expected Result**: The condition is met.

### Conclusion

These test cases cover the edge scenarios for the condition `FICO > 750 && FICO <= 900 AND N_INQ < 2`. They ensure that the condition is correctly evaluated for various combinations of FICO scores and number of inquiries.