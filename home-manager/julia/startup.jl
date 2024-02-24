include("repl.jl")

atreplinit() do repl
    @eval import REPL
    if !isdefined(repl, :interface)
        repl.interface = REPL.setup_interface(repl)
    end
    numbered_prompt!(repl)
    show_banner(stdout)
end
