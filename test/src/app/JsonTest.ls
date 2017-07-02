package
{
    import system.application.ConsoleApplication;
    import system.Process;

    import pixeldroid.bdd.SpecExecutor;

    import JsonSpec;
    import JsonPrinterSpec;
    import YamlPrinterSpec;

    public class JsonTest extends ConsoleApplication
    {
        override public function run():void
        {
            SpecExecutor.parseArgs();

            var returnCode:Number = SpecExecutor.exec([
                JsonSpec,
                JsonPrinterSpec,
                YamlPrinterSpec
            ]);

            Process.exit(returnCode);
        }
    }

}
