import Pkg
Pkg.add("GenieFramework")
using Genie

Genie.newapp("digit-recognition", dbadapter= :SQLite)
