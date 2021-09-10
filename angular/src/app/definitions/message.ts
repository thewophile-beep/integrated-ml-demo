export class Message {
    message: string = "";
    verbose: boolean = true;

    constructor(message: string,verbose: boolean) {
        this.message=message
        this.verbose=verbose
    }
}