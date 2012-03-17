package circuit.base
{
import circuit.api.Circuit;
import circuit.core.BreakerOperate;

public class CircuitRetriever
{
    private var _clientCircuit:Circuit;

    public function CircuitRetriever( clientCircuit:Circuit )
    {
        _clientCircuit = clientCircuit;

    }

    public function getConnectedCircuits( breakers:Array ):Array
    {
        const a:Array = [];
        for each ( var breaker:BreakerOperate in breakers )
        {
            if ( breaker.isClosed )
            {
                a.push( breaker.getOtherCircuit( _clientCircuit ) );
            }
        }
        return a;
    }


}
}
