package circuit.signals
{
import circuit.api.PowerSupply;

import org.osflash.signals.Signal;

public class PowerSupplyChangedSignal extends Signal
{
    public function PowerSupplyChangedSignal(  )
    {
        super( PowerSupply );
    }

    public function dispatchPowerSupply( value:PowerSupply ):void
    {
        dispatch( value );
    }
}
}
