program custom_exception;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  Horse,
  System.SysUtils,
  Horse.Jhonson,
  Controller.Auth in 'src\controllers\Controller.Auth.pas',
  Middleware.HorseServerExceptions in 'src\middlewares\Middleware.HorseServerExceptions.pas',
  InvalidCredentials in 'src\exceptions\InvalidCredentials.pas',
  Contract.HorseServerExceptionConverter in 'src\contracts\Contract.HorseServerExceptionConverter.pas',
  HorseServerExceptionConverter.InvalidCredentials in 'src\exception-convertes\HorseServerExceptionConverter.InvalidCredentials.pas',
  InvalidRequest in 'src\exceptions\InvalidRequest.pas',
  HorseServerExceptionConverter.InvalidRequest in 'src\exception-convertes\HorseServerExceptionConverter.InvalidRequest.pas';

begin
  THorse.Use(Jhonson());
  THorse.Use(THorseServerExceptions.Invoke);

  TAuthController.Register;
  THorse.Listen;

end.
