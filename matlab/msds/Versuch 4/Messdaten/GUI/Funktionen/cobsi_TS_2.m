function output = cobsi_TS_2(input)
	%COBSI Decode a message from Consistent Overhead Byte Stuffing - see
    % http://www.stuartcheshire.org/papers/cobsforton.pdf for algorithm
    % details
    
    global Disp_Errors 

    read_index  = 1;
    write_index = 1;
    code       = 0;
    
    l = length(input);
    
    if (l == 0)
            output = 0;
    else
        while (read_index <= l)
            code = input(read_index);

            if ((read_index + code > l+1) && (code ~= 1))
                if (Disp_Errors == 1)
                    disp('Fehlerhafter Datensatz--------------------------------------------------------------------------------')
                end
                code = l-read_index;
                output = 0;
                break;
            end

            read_index = read_index + 1;

            for i = 1:code-1
                output(write_index) = input(read_index);
                write_index = write_index + 1;
                read_index = read_index + 1;
            end

            if ((code ~= 255) && (read_index ~= l+1))
                output(write_index) = 0;
                write_index = write_index + 1;
            end
        end
    end  
    output(end) = [];
end