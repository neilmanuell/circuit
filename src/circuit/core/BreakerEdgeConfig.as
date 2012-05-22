package circuit.core
{
import circuit.api.*;

public interface BreakerEdgeConfig
{
    function add(a:Node, b:Node):Boolean
    function has(circuit:Node):Boolean

}
}
