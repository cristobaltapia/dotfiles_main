try
    using Revise
catch e
    @warn "Error initializing Revise" exception=(e, catch_backtrace())
end

try
    using Debugger
catch e
    @warn "Error initializing Debugger" exception=(e, catch_backtrace())
end
