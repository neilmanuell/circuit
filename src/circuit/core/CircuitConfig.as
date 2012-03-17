package circuit.core
{
import circuit.api.*;

public interface CircuitConfig
{
    function add( breaker:Breaker ):Boolean

    function has( breaker:Breaker ):Boolean

}
}
