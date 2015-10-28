Attachments = new FS.Collection("attachments", {
  stores: [new FS.Store.FileSystem("attachments", {path: "~/uploads"})]
});

FS.HTTP.setBaseUrl('/files');