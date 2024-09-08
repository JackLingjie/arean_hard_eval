def lcs(str1, str2): 
    m = len(str1) 
    n = len(str2) 
  
    # Creating a table to store the dp values 
    lcs_table = [[0 for x in range(n+1)] for x in range(m+1)] 
  
    # Filling the table in bottom-up manner 
    for i in range(m+1): 
        for j in range(n+1): 
            # If first string is empty, only option is to 
            # append second string 
            if i == 0: 
                lcs_table[i][j] = j 
  
            # If second string is empty, only option is to 
            # append first string 
            elif j == 0: 
                lcs_table[i][j] = i 
  
            # If last characters are same, ignore last char 
            # and recur for remaining string 
            elif str1[i-1] == str2[j-1]: 
                lcs_table[i][j] = lcs_table[i-1][j-1] + 1
  
            # If last character are different, 
            # ignore last char and take maximum of 
            # the other two possibilities 
            else: 
                lcs_table[i][j] = max(lcs_table[i-1][j], lcs_table[i][j-1]) 
  
    # Lenght of the longest common subsequence is the last value in the table 
    return lcs_table[m][n]