function output = cobs_TS(input)

    read_index = 1;
    write_index = 2;
    code_index = 1;
    code = 1;
    
    l = length(input); 
    
    output = zeros(0, l + ceil(l/255) + 1, 'uint8'); % preallocate

    while (read_index < l+1)
            if (input(read_index) == 0)
                output(code_index) = code;
                code = 1;
                code_index = write_index;
                write_index = write_index+1;
                read_index=read_index+1;
            else
                output(write_index) = input(read_index);
                write_index = write_index+1;
                read_index = read_index+1;
                code = code+1;
           
                if (code == 255)
                    output(code_index) = code;
                    code = 1;
                    code_index = write_index;
                    write_index = write_index+1;
                end
            end
    end

    output(code_index) = code;
    output = cat(2,output,0);
end