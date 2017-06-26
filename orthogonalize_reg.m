function [out_matrix] = orthogonalize_reg(reg_matrix,ortho_reg,ortho_by)
% orthogonalize_reg: orthogonalizes a given regressor (ortho_reg)
% with regard to other regressors (ortho_by)

	this_reg = reg_matrix(:,ortho_reg);
	other_regs = reg_matrix(:,ortho_by);
	[b,bint,r]=regress(this_reg,other_regs);
	out_matrix=r;
end % end function