package vektah.rust.psi.mixin.item;

import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiNamedElement;
import com.intellij.util.IncorrectOperationException;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;
import vektah.rust.psi.RustImplItem;
import vektah.rust.psi.RustType;
import vektah.rust.psi.impl.RustItemImpl;

/**
 * (C) Atlassian 2014
 */
public abstract class RustImplItemMixin extends RustItemImpl implements RustImplItem, PsiNamedElement {
    public RustImplItemMixin(ASTNode node) {
        super(node);
    }

    @Override
    public PsiElement setName(@NonNls @NotNull String s) throws IncorrectOperationException {
        return null;
    }

    @Override
    public String getName() {
        RustType type = getType();

        if (type != null) {
            return type.getText();
        }

        return null;
    }
}
