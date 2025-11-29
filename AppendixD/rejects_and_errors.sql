COPY INTO stage.rejected FROM @landing/files
FILE_FORMAT=(TYPE=CSV) ON_ERROR='CONTINUE';  -- quantify waste; fix at source
