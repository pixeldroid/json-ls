package
{
    import system.application.ConsoleApplication;
    import system.Process;

    import pixeldroid.bdd.SpecExecutor;

    import JsonSpec;
    import JsonPrinterSpec;


    public class JsonTest extends ConsoleApplication
    {
        override public function run():void
        {
            SpecExecutor.parseArgs();

            var returnCode:Number = SpecExecutor.exec([
                JsonSpec,
                JsonPrinterSpec
            ]);

            Process.exit(returnCode);
        }
    }

}
