package circuit.signals
{
import circuit.api.PowerSupply;

import net.richardlord.ash.signals.Signal1;

public class PowerSupplyChangedSignal extends Signal1
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
