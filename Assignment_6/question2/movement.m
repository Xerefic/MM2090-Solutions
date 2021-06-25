# Initializing the State

state = zeros(130,130);

for row = 2:size(state)(1)-1
    for column = 2:size(state)(2)-1
        value = rand();
        if (value>=0.5)
            state(row,column)=255;
        endif
    endfor
endfor
history = state;

#imshow(state)
imwrite(state, "Iteration-0.png")

# Performing the Operations

N = 3*10^5;
for time = 1:N
    x = floor(rand()*size(state)(1));
    y = floor(rand()*size(state)(2));
    if ((x>2)&&(x<size(state)(1)-2)&&(y>2)&&(y<size(state)(2)-2))
        like = sum(sum(state(x-1:x+1, y-1:y+1)));
        if (like>4*255)
            state(x,y)=255;
        else
            state(x,y)=0;
        endif
    endif
    if (time<10000)
        if (mod(time,100)==0)
            name = sprintf("Iteration-%d.png", time);
            imwrite(state, name);
        endif
    else
        if (mod(time,1000)==0)
            name = sprintf("Iteration-%d.png", time);
            imwrite(state, name);
        endif
    endif
endfor
