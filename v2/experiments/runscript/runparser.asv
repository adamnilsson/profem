function runparser(filename)
% [L, F, M]
% row1: [m, N, kg]
% row2: [mm, N, tonne]
units = [1 1 1; 1e-3, 1, 1e-3];

fid = fopen(filename);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    tdata = regexp(tline,';','split');
    if strcmp(tdata(1),'CMD')
        if strcmp(tdata(2),'STATIC')
            meshdata = tdata{3};
            uindex = str2double(tdata{4});
            staticfea(meshdata,units(uindex,:),1);
        end
    end
end
fclose(fid);