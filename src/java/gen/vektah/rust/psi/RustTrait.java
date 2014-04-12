// This is a generated file. Not intended for manual editing.
package vektah.rust.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface RustTrait extends PsiElement {

  @NotNull
  List<RustFunctionDeclaration> getFunctionDeclarationList();

  @Nullable
  RustFunctionType getFunctionType();

  @Nullable
  RustGenericParams getGenericParams();

  @Nullable
  RustTypeBasic getTypeBasic();

  @Nullable
  RustTypeClosure getTypeClosure();

  @Nullable
  RustTypeNone getTypeNone();

  @Nullable
  RustTypeProc getTypeProc();

  @Nullable
  RustTypeTuple getTypeTuple();

}
