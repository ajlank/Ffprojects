class CloudExceptions implements Exception{
  const CloudExceptions();
}

class CouldNotGetNoteException extends CloudExceptions{}
class CouldNotCreateNoteException extends CloudExceptions{}
class CouldNotUpdateNoteException extends CloudExceptions{}
class CouldNotDeleteNoteException extends CloudExceptions{}
