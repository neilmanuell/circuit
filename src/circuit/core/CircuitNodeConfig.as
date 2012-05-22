package circuit.core
{
import circuit.api.*;

public interface CircuitNodeConfig
{
    function add( breaker:Edge ):Boolean

    function has( breaker:Edge ):Boolean

}
}
