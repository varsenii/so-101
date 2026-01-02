SITEPKG=$(python - <<'PY'
import sysconfig, os, site
p = sysconfig.get_paths().get("purelib")
if p and os.path.isdir(p):
    print(p); raise SystemExit
for q in site.getsitepackages():
    if os.path.isdir(q):
        print(q); break
PY
)

if [ -z "$SITEPKG" ]; then
  echo "ERROR: could not find site-packages for this Python. Aborting."
  exit 1
fi

echo "Using site-packages: $SITEPKG"

cat > "$SITEPKG/sitecustomize.py" <<'PY'
# rerun compatibility shim: provide rr.Scalar if only rr.Scalars exists
# Safe: only runs if rerun imports successfully.
try:
    import rerun as rr
    if not hasattr(rr, "Scalar") and hasattr(rr, "Scalars"):
        def Scalar(value, *args, **kwargs):
            """
            Emulate old rr.Scalar by delegating to rr.Scalars:
            - Scalar(1.2) -> Scalars([1.2])
            - Scalar(np.array(...)) -> Scalars(array) (passes arrays through)
            - Scalar(torch.Tensor) -> convert to cpu numpy if possible, then wrap
            """
            v = value
            # convert torch tensors -> numpy if possible
            try:
                import torch as _torch
                if isinstance(v, _torch.Tensor):
                    v = v.detach().cpu().numpy()
            except Exception:
                pass
            # numpy scalars/0-d arrays -> python scalar or pass-through
            try:
                import numpy as _np
                if isinstance(v, _np.generic):
                    v = v.item()
                # if array-like with ndim attribute
                if getattr(v, "ndim", None) is not None:
                    return rr.Scalars(v, *args, **kwargs)
            except Exception:
                pass
            # lists/tuples -> pass through, else wrap single value in list
            if isinstance(v, (list, tuple)):
                return rr.Scalars(v, *args, **kwargs)
            return rr.Scalars([v], *args, **kwargs)
        rr.Scalar = Scalar
except Exception:
    # do nothing if rerun not installed or import fails
    pass
PY

# show file info
ls -l "$SITEPKG/sitecustomize.py"
