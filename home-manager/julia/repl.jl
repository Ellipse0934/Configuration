# REPL-customizations
# See REPL.jl, maybe some version eval is in order for
# backwards + future compatibility.

# See: julialang/julia/stdlib/REPL/src/REPL.jl
# This is mostly copied from there
import REPL:
    LineEditREPL,
    Numbered.repl_eval_counter

"""
    show_banner(io)

Kinda annoying that Base.banner cannot be overwritten in startup.jl
and there is no vanilla option to set custom banner.
"""
function show_banner(io)
    commit_short = Base.GIT_VERSION_INFO.commit_short
	commit_ts = Base.GIT_VERSION_INFO.date_string
	print("DateTime: $(read(`date -Iminutes`, String))")
	println("Version: $VERSION")
	println("Commit: $(commit_short) ($(commit_ts))")
    println("Threads: $(Threads.nthreads())")
end


function numbered_prompt!(repl::LineEditREPL=Base.active_repl, backend=nothing)
    n = Ref{Int}(0)
    set_prompt(repl, n)
    set_output_prefix(repl, n)
    return
end

function set_prompt(repl::LineEditREPL, n::Ref{Int})
    julia_prompt = repl.interface.modes[1]
    julia_prompt.prompt = function()
        n[] = repl_eval_counter(julia_prompt.hist)+1
        string("λ ⟨", n[], "⟩ ➢ ")
    end
    nothing
end

function set_output_prefix(repl::LineEditREPL, n::Ref{Int})
    julia_prompt = repl.interface.modes[1]
    if REPL.hascolor(repl)
        julia_prompt.output_prefix_prefix = Base.text_colors[:red]
    end
    julia_prompt.output_prefix = () -> string("Ω ⟨", n[], "⟩ ➢ ")
    nothing
end
