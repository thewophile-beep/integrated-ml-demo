import { Injectable } from '@angular/core';
import { Message } from '../definitions/message'

@Injectable({
  providedIn: 'root'
})
export class MessageService {
  messages: Message[] = [];

  add(message: string) {
    this.messages.push(new Message(message,true));
  }

  addMessage(message: string,verbose:boolean) {
    this.messages.push(new Message(message,verbose));
  }

  clear() {
    this.messages = [];
  }

  constructor() { }
}
