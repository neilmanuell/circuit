package circuit.core
{
import circuit.api.*;

public interface BreakerConfig
{
    function add(a:Circuit, b:Circuit):Boolean
    function has(circuit:Circuit):Boolean

}
}
