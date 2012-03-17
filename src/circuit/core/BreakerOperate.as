package circuit.core
{
import circuit.api.*;

public interface BreakerOperate   extends Breaker
{

    function getOtherCircuit( thisCircuit:Circuit):Circuit


}
}
