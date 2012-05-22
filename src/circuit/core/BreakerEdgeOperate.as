package circuit.core
{
import circuit.api.*;

public interface BreakerEdgeOperate   extends Edge
{

    function getOtherCircuit( thisCircuit:Node):Node


}
}
