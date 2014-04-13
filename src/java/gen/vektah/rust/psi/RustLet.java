// This is a generated file. Not intended for manual editing.
package vektah.rust.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface RustLet extends PsiElement {

  @Nullable
  RustExpression getExpression();

  @NotNull
  List<RustFunctionType> getFunctionTypeList();

  @Nullable
  RustRef getRef();

  @NotNull
  List<RustTypeBasic> getTypeBasicList();

  @NotNull
  List<RustTypeClosure> getTypeClosureList();

  @NotNull
  List<RustTypeNone> getTypeNoneList();

  @NotNull
  List<RustTypeProc> getTypeProcList();

  @NotNull
  List<RustTypeTuple> getTypeTupleList();

}
