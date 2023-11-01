# Blatt 7, Aufgabe B

def drucke_summen(matrix):
    sum_s = [0]*len(matrix[0])
    sum_z = [0]*len(matrix)

    for i in range(0, len(matrix)):
        for j in range(0, len(matrix[i])):
            print(format(matrix[i][j], '>2'), end=' ')
            sum_s[j] += matrix[i][j]
            sum_z[i] += matrix[i][j]
        
        print('|', sum_z[i])
    
    print('-'*12, '|', '-'*3, sep='')
    
    for sum_s_v in sum_s:
        print(format(sum_s_v, '>2'), end= ' ')

    print('|', sum(sum_s))

    



drucke_summen([
    [4, 5, 2, 7],
    [3, 6, 1, 9],
    [9, 8, 2, 6]
])