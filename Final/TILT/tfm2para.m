% Kelvin Zhang, Arvind Ganesh, February 2011. 
% Questions? zhangzdfaint@gmail.com, abalasu2@illinois.edu
%
% Copyright: Perception and Decision Laboratory, University of Illinois, Urbana-Champaign
%            Microsoft Research Asia, Beijing
%
% Reference: TILT: Transform Invariant Low-rank Textures  
%            Zhengdong Zhang, Xiao Liang, Arvind Ganesh, and Yi Ma. Proc. of ACCV, 2010.
%

function tau=tfm2para(tfm_matrix, XData, YData, mode)
% tfm2para will transpose tfm_matrix to its corresponding parameter.
% -------------------------input------------------------------------------
% tfm_matrix:       3-by-3 matrix.
% mode:             one of 'euclidean', 'euclidean_notranslation', 'affine', 'affine_notranslation', 
%                   'homography', 'homography_notranslation'
% -------------------------output-----------------------------------------
% tau:              p-by-1 real vector.
switch lower(mode)
    case 'euclidean'
        tau=zeros(3, 1);
        tau(2:3, 1)=tfm_matrix(1:2, :);
        tau(1)=acos(tfm_matrix(1, 1));
        if tfm_matrix(2, 1)<0
            tau(1)=-tau(1);
        end
    case 'euclidean_notranslation'
        tau=zeros(1, 1);
        tau(1)=acos(tfm_matrix(1, 1));
        if tfm_matrix(2, 1)<0
            tau(1)=-tau(1);
        end
    case 'affine'
        tau=zeros(6, 1);
        tau(1:3)=tfm_matrix(1, :)';
        tau(4:6)=tfm_matrix(2, :)';
    case 'affine_notranslation'
        tau=zeros(4, 1);
        tau(1:2)=tfm_matrix(1, 1:2)';
        tau(3:4)=tfm_matrix(2, 1:2)';
    case {'homography_special', 'homography_special_notranslation'}
        X=[XData(1) XData(2) XData(2) XData(1)];
        Y=[YData(1) YData(1) YData(2) YData(2)];
        pt=[X; Y; ones(1, 4)];
        tfm_pt=tfm_matrix*pt;
        tfm_pt(1, :)=tfm_pt(1, :)./tfm_pt(3, :);
        tfm_pt(2, :)=tfm_pt(2, :)./tfm_pt(3, :);
        tau=reshape(tfm_pt(1:2, :), 8, 1);
    case {'homography','homography_notranslation'}
        tau=zeros(8, 1);
        tau(1)=tfm_matrix(2, 1)/tfm_matrix(1, 1);
        tau(2)=tfm_matrix(3, 1)/tfm_matrix(1, 1);
        tau(3)=tfm_matrix(1, 2)/tfm_matrix(2, 2);
        tau(4)=tfm_matrix(3, 2)/tfm_matrix(2, 2);
        pt=[XData; YData; ones(1, 2)];
        pt_trans=tfm_matrix*pt;
        pt_trans=pt_trans./(ones(3, 1)*pt_trans(3, :));
        pt_trans=pt_trans(1:2, :);
        tau(5:8)=pt_trans(:);
end