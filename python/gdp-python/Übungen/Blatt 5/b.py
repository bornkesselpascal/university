def längste_folge(str):
    i = 0
    maxlen = 0
    start = 0
    end = 0

    while i < len(str):
        j = i+1
        while j < len(str) and str[j] >= str[j-1]:
            j+=1

            if(j-i) > (end-start):
                start = i
                end = j

        i = j

    return str[start:end]



print('"' + längste_folge('Weihnachten') + '"')