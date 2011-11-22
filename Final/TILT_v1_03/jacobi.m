% Kelvin Zhang, Arvind Ganesh, February 2011. 
% Questions? zhangzdfaint@gmail.com, abalasu2@illinois.edu
%
% Copyright: Perception and Decision Laboratory, University of Illinois, Urbana-Champaign
%            Microsoft Research Asia, Beijing
%
% Reference: TILT: Transform Invariant Low-rank Textures  
%            Zhengdong Zhang, Xiao Liang, Arvind Ganesh, and Yi Ma. Proc. of ACCV, 2010.
%

function J=jacobi(du, dv, XData, YData, tau, mode)
% jacobi() will calculate the jacobi matrix.
% ------------------------------input--------------------------------------
% du:           m-by-n matrix, derivative along x-axis;
% dv:           m-by-n matrtix, derivative along y-axis;
% UData:        1-by-2 vector, X-range of the image.
% VData:        1-by-2 vector, Y-range of the image.
% tfm_matrix:   3-by-3 matrix, transformation matrix.
% mode:         one of 'affine', 'affine_notranslation', 'homography',
%               'homography_notranslation'
%
% ------------------------------output-------------------------------------
% J:            m-by-n-by-p tensor, jacobi matrix.

%% generate location map
[m n]=size(du);
[X0 Y0]=meshgrid(XData(1):XData(2), YData(1):YData(2));

%% generate jacobi matrix
switch lower(mode)
    case 'affine'
        J=zeros(m, n, 6);
        J(:, :, 1)=X0.*du;
        J(:, :, 2)=Y0.*du;
        J(:, :, 3)=du;
        J(:, :, 4)=X0.*dv;
        J(:, :, 5)=Y0.*dv;
        J(:, :, 6)=dv;
    case 'affine_notranslation'
        J=zeros(m, n, 4);
        J(:, :, 1)=X0.*du;
        J(:, :, 2)=Y0.*du;
        J(:, :, 3)=X0.*dv;
        J(:, :, 4)=Y0.*dv;
    case {'homography', 'homography_notranslation'}
        [m n]=size(du);
        [X0 Y0]=meshgrid(XData(1):XData(2), YData(1):YData(2));
        H=para2tfm(tau, XData, YData, mode);
        N1=H(1, 1)*X0+H(1, 2)*Y0+H(1, 3);
        N2=H(2, 1)*X0+H(2, 2)*Y0+H(2, 3);
        N=H(3, 1)*X0+H(3, 2)*Y0+1;
        dIdH=zeros(m, n, 8);
        dIdH(:, :, 1)=du.*X0./N;
        dIdH(:, :, 2)=du.*Y0./N;
        dIdH(:, :, 3)=du./N;
        dIdH(:, :, 4)=dv.*X0./N;
        dIdH(:, :, 5)=dv.*Y0./N;
        dIdH(:, :, 6)=dv./N;
        dIdH(:, :, 7)=du.*(-N1./N.^2.*X0)+dv.*(-N2./N.^2.*X0);
        dIdH(:, :, 8)=du.*(-N1./N.^2.*Y0)+dv.*(-N2./N.^2.*Y0);
        dPdH=zeros(8, 8);
        dPdH(1, 1)=-H(2, 1)/H(1, 1)^2;
        dPdH(1, 4)=1/H(1, 1);
        dPdH(2, 1)=-H(3, 1)/H(1, 1)^2;
        dPdH(2, 7)=1/H(1, 1);
        dPdH(3, 5)=-H(1, 2)/H(2, 2)^2;
        dPdH(3, 2)=1/H(2, 2);
        dPdH(4, 5)=-H(3, 2)/H(2, 2)^2;
        dPdH(4, 8)=1/H(2, 2);
        N1=H(1, 1)*XData+H(1, 2)*YData+H(1, 3);
        N2=H(2, 1)*XData+H(2, 2)*YData+H(2, 3);
        N=H(3, 1)*XData+H(3, 2)*YData+1;
        dPdH(5, :)=[XData(1)/N(1); YData(1)/N(1); 1/N(1); 0;0;0; -N1(1)/N(1)^2*XData(1); -N1(1)/N(1)^2*YData(1)];
        dPdH(6, :)=[0;0;0; XData(1)/N(1); YData(1)/N(1); 1/N(1); -N2(1)/N(1)^2*XData(1); -N2(1)/N(1)^2*YData(1)];
        dPdH(7, :)=[XData(2)/N(2); YData(2)/N(2); 1/N(2); 0;0;0; -N1(2)/N(2)^2*XData(2); -N1(2)/N(2)^2*YData(2)];
        dPdH(8, :)=[0;0;0; XData(2)/N(2); YData(2)/N(2); 1/N(2); -N2(2)/N(2)^2*XData(2); -N2(2)/N(2)^2*YData(2)];
        dHdP=inv(dPdH);
        J=zeros(m, n, 8);
        
        if strcmp(lower(mode), 'homography_notranslation')
            for i=1:4
                for j=1:8
                    J(:, :, i)=J(:, :, i)+dIdH(:, :, j)*dHdP(j, i);
                end
            end
        else
            for i=1:8
                for j=1:8
                    J(:, :, i)=J(:, :, i)+dIdH(:, :, j)*dHdP(j, i);
                end
            end
        end
    case {'homography_special', 'homography_special_notranslation'}
        [m n]=size(du);
        [X0 Y0]=meshgrid(XData(1):XData(2), YData(1):YData(2));
        H=para2tfm(tau, XData, YData, mode);
        N1=H(1, 1)*X0+H(1, 2)*Y0+H(1, 3);
        N2=H(2, 1)*X0+H(2, 2)*Y0+H(2, 3);
        N=H(3, 1)*X0+H(3, 2)*Y0+1;
        dIdH=zeros(m, n, 8);
        dIdH(:, :, 1)=du.*X0./N;
        dIdH(:, :, 2)=du.*Y0./N;
        dIdH(:, :, 3)=du./N;
        dIdH(:, :, 4)=dv.*X0./N;
        dIdH(:, :, 5)=dv.*Y0./N;
        dIdH(:, :, 6)=dv./N;
        dIdH(:, :, 7)=du.*(-N1./N.^2.*X0)+dv.*(-N2./N.^2.*X0);
        dIdH(:, :, 8)=du.*(-N1./N.^2.*Y0)+dv.*(-N2./N.^2.*Y0);
        
        dPdH=zeros(8, 8);
        X=[XData(1) XData(2) XData(2) XData(1)];
        Y=[YData(1) YData(1) YData(2) YData(2)];
        N1=X*H(1, 1)+Y*H(1, 2)+H(1, 3);
        N2=X*H(2, 1)+Y*H(2, 2)+H(2, 3);
        N=X*H(3, 1)+Y*H(3, 2)+1;
        temp=reshape(tau, 2, 4);
        U=temp(1, :);
        V=temp(2, :);
        for i=1:4
            dPdH(2*i-1, 1)=X(i)/N(i);
            dPdH(2*i-1, 2)=Y(i)/N(i);
            dPdH(2*i-1, 3)=1/N(i);
            dPdH(2*i-1, 7)=-N1(i)/N(i)^2*X(i);
            dPdH(2*i-1, 8)=-N1(i)/N(i)^2*Y(i);
            dPdH(2*i, 4)=X(i)/N(i);
            dPdH(2*i, 5)=Y(i)/N(i);
            dPdH(2*i, 6)=1/N(i);
            dPdH(2*i, 7)=-N2(i)/N(i)^2*X(i);
            dPdH(2*i, 8)=-N2(i)/N(i)^2*Y(i);
        end
        dHdP=inv(dPdH);
        J=zeros(m, n, 8);
        if strcmp(lower(mode), 'homography_special_notranslation')
            for i=3:4
                for j=1:8
                    J(:, :, i)=J(:, :, i)+dIdH(:, :, j)*dHdP(j, i);
                end
            end
            for i=7:8
                for j=1:8
                    J(:, :, i)=J(:, :, i)+dIdH(:, :, j)*dHdP(j, i);
                end
            end
        else
            for i=1:8
                for j=1:8
                    J(:, :, i)=J(:, :, i)+dIdH(:, :, j)*dHdP(j, i);
                end
            end
        end
end        